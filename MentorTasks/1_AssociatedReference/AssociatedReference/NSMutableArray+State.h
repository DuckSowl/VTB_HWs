//
//  NSMutableArray+State.h
//  AssociatedReference
//
//  Created by Anton Tolstov on 19.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (State)

// Can't add property to a Category
// @property NSMutableArray* state;

- (void)saveState;
- (void)removeState;
- (NSMutableArray*)getSavedState;

@end

NS_ASSUME_NONNULL_END
