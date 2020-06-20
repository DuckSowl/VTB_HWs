//
//  NSMutableArray+Functional.m
//  VTB HW2
//
//  Created by Anton Tolstov on 20.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

#import "NSMutableArray+Functional.h"

@implementation NSMutableArray (Functional)

+ (instancetype)arrayWithIntegerRangeFrom:(NSInteger)fromValue to:(NSInteger)toValue {
    if (fromValue > toValue) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (int value = (int)fromValue; value < (int)toValue; value++) {
        [array addObject:@(value)];
    }
    
    return array;
}


- (void)mapObjectsUsingBlock:(id(^)(id))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        self[idx] = block(self[idx]);
    }];
}

- (id)foldObjectsUsingBlock:(id(^)(id, id))block withInitialState:(id)initialState {
    if (!self.count) {
        return nil;
    }
    
    __block id accumulator = initialState;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        accumulator = block(accumulator, self[idx]);
        if (idx == (self.count - 1)) {
            *stop = YES;
        }
    }];
    
    return accumulator;
}

- (id)reduceObjectsUsingBlock:(id(^)(id, id))block {
    if (!self.count) {
        return nil;
    }

    id accumulator = [self objectAtIndex:[@0 unsignedLongValue]];
    for (int i = 1; i <= self.count - 1; i++) {
        accumulator = block(accumulator, self[i]);
    }

    return accumulator;
}

@end
