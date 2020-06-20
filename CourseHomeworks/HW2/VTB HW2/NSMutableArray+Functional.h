//
//  NSMutableArray+Functional.h
//  VTB HW2
//
//  Created by Anton Tolstov on 20.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Functional)

+ (nullable instancetype)arrayWithIntegerRangeFrom:(NSInteger)fromValue to:(NSInteger)toValue;

- (void)mapObjectsUsingBlock:(id(^)(id))block;
- (nullable id)foldObjectsUsingBlock:(id(^)(id, id))block withInitialState:(id)initialState;
- (nullable id)reduceObjectsUsingBlock:(id(^)(id, id))block;

@end

NS_ASSUME_NONNULL_END
