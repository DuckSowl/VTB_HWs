//
//  main.m
//  VTB HW1
//
//  Created by Anton Tolstov on 18.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Contacts.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *names = @[@"Alex", @"Nick", @"Mike", @"SOS", @"John"];
        NSDictionary *phoneNumbers = @{
            @"Alex" : @12345678909,
            @"Nick" : @77777777777,
            @"SOS"  : @112,
            @"John" : @12345654321
        };
        
        Contacts *contacts = [[Contacts alloc] initWithNamesArray:names andPhoneNumbersDictionary:phoneNumbers];
        
        [contacts printContacts];
    }
    return 0;
}
