//
//  main.m
//  AssociatedReference
//
//  Created by Anton Tolstov on 19.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSMutableArray+State.h"

void printMutableArray(NSMutableArray *arr) {
    NSLog(@"[%@]", [arr componentsJoinedByString:@", "]);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *numbers = [@[@1, @2, @3] mutableCopy];
        printMutableArray(numbers);
        NSLog(@"%@", [numbers getSavedState] ?: @"No state");

        [numbers saveState];
        [numbers addObject:@4];
        printMutableArray(numbers);
        printMutableArray([numbers getSavedState]);
        
        [numbers removeState];
        NSLog(@"%@", [numbers getSavedState] ?: @"No state");
    }
    return 0;
}
