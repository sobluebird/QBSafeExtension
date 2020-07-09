//
//  NSMutableDictionary+Safe.m
//  test
//
//  Created by QB on 2020/5/29.
//

#import "NSMutableDictionary+QBSafe.h"
#import "NSObject+QBExchangeImp.h"

@implementation NSMutableDictionary (QBSafe)

+ (void)load {
    Class class = NSClassFromString(@"__NSDictionaryM");
    
    [self exchangeIMP_InstanceSelectorA:@selector(swizzling_setObject:forKey:) InstanceSelectorB:@selector(setObject:forKey:) WithClass:class];
    
    [self exchangeIMP_InstanceSelectorA:@selector(setObject:forKeyedSubscript:) InstanceSelectorB:@selector(swizzling_setObject:forKeyedSubscript:) WithClass:class];
    
    [self exchangeIMP_InstanceSelectorA:@selector(removeObjectForKey:) InstanceSelectorB:@selector(swizzling_removeObjectForKey:) WithClass:class];
}


- (void)swizzling_setObject:(id)value forKey:(NSString *)key
{
    if (!value || !key) {
        QBLog(@"NSMutableDictionary  添加的value or  Obj 为空");
        return;
    }
    
    [self swizzling_setObject:value forKey:key];
}

- (void)swizzling_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (!obj || !key) {
        QBLog(@"NSMutableDictionary  添加的key 或 Obj 为空");
        return;
    }
    
    [self swizzling_setObject:obj forKeyedSubscript:key];
}

- (void)swizzling_removeObjectForKey:(id)aKey {
    if (aKey) {
        [self swizzling_removeObjectForKey:aKey];
    }
    else {
        QBLog(@"NSMutableDictionary aKey为nil");
    }
}

@end
