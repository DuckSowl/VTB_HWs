//
//  Contacts.m
//  VTB HW1
//
//  Created by Anton Tolstov on 18.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

#import "Contacts.h"

// Maybe it's better to make properties private. Depends on the situation
//@interface Contacts ()
//@property NSArray* names;
//@property NSDictionary* phoneNumbers;
//@end

@implementation Contacts

- (instancetype)initWithNamesArray:(NSArray*)names andPhoneNumbersDictionary:(NSDictionary*)phoneNumbers {
    if (self = [super init]) {
        self.names = names;
        self.phoneNumbers = phoneNumbers;
    }
    return self;
}

- (void)printContacts {
    NSLog(@"Contacts: [");
    for (NSString *name in self.names) {
        NSString *phoneNumber = [[self.phoneNumbers valueForKey:name] stringValue];
        if ([phoneNumber length] == 11) {
            phoneNumber = [self formatPhoneNumberFromString:phoneNumber];
        }
        NSLog(@"\t%@ : %@", name, phoneNumber ?: @"No number");
    }
    NSLog(@"]");
}

// Just practicing with string manipulation
- (NSString*)formatPhoneNumberFromString:(NSString*)phoneNumber {
    return [NSString stringWithFormat:@"+%@(%@)%@-%@-%@",
         [phoneNumber substringToIndex:1],
         [phoneNumber substringWithRange:NSMakeRange(1, 3)],
         [phoneNumber substringWithRange:NSMakeRange(4, 3)],
         [phoneNumber substringWithRange:NSMakeRange(7, 2)],
         [phoneNumber substringWithRange:NSMakeRange(9, 2)]
    ];
}

@end
