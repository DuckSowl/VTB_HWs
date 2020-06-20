//
//  main.m
//  VTB HW2
//
//  Created by Anton Tolstov on 20.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSMutableArray+Functional.h"

void printMutableArray(NSMutableArray *arr, NSString *comment) {
    if (comment) {
        printf("%s: ", [comment UTF8String]);
    }
    
    printf("[%s]\n", [[arr componentsJoinedByString:@", "] UTF8String]);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *numbers = [NSMutableArray arrayWithIntegerRangeFrom:0 to:5 + 1];
        printMutableArray(numbers, @"Initial values");
        
        [numbers mapObjectsUsingBlock:^id (id number) {
            return @([number intValue] + 3);
        }];
        printMutableArray(numbers, @"After addition 3");
        
        int sum = [[numbers foldObjectsUsingBlock:^id (id first, id second) {
                        return @([first intValue] + [second intValue]);
                    } withInitialState:@0] intValue];
        printf("Sum with fold: %d\n", sum);
        
        // Defining all of this only to show that I can
        typedef id (^PairApplyBlockType)(id, id);
        PairApplyBlockType intProductBlock = ^id (id first, id second) {
            return @([first intValue] * [second intValue]);
        };
        printf("Product with reduce: %d\n",
               [[numbers reduceObjectsUsingBlock:intProductBlock] intValue]);
        
        [numbers removeAllObjects];
        printf("Reduce with no objects: %s\n",
               [[numbers reduceObjectsUsingBlock:intProductBlock] ?: @"nil" UTF8String]);
        
        [numbers addObject:@42];
        printf("Reduce with one object: %d",
               [[numbers reduceObjectsUsingBlock:intProductBlock] intValue]);
        printMutableArray(numbers, @", array");
        
        [numbers addObject:@13];
        printf("And with two objects: %d",
               [[numbers reduceObjectsUsingBlock:intProductBlock] intValue]);
        printMutableArray(numbers, @", array");
    }
    return 0;
}
