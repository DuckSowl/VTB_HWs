//
//  Contacts.h
//  VTB HW1
//
//  Created by Anton Tolstov on 18.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contacts : NSObject

@property NSArray* names;
@property NSDictionary* phoneNumbers;

- (instancetype)initWithNamesArray:(NSArray*)names andPhoneNumbersDictionary:(NSDictionary*)phoneNumbers;
- (void)printContacts;

@end

NS_ASSUME_NONNULL_END
