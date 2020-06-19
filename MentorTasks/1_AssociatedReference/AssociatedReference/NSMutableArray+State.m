//
//  NSMutableArray+State.m
//  AssociatedReference
//
//  Created by Anton Tolstov on 19.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

#import <objc/runtime.h>

#import "NSMutableArray+State.h"

@implementation NSMutableArray (State)

static char stateKey;

- (void)saveState {
    objc_setAssociatedObject(self, &stateKey, self, OBJC_ASSOCIATION_COPY);
}

- (void)removeState {
    objc_setAssociatedObject(self, &stateKey, nil, OBJC_ASSOCIATION_COPY);
}

- (NSMutableArray*)getSavedState {
    return (NSMutableArray*)objc_getAssociatedObject(self, &stateKey);
}

@end
