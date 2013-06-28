//
//  Account2.h
//  BankAccount
//
//  Created by Le Duy Thanh on 28/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account2 : NSObject

@property(strong, nonatomic)NSString *accountNumber;
@property(strong, nonatomic)NSNumber *balance;
@property(strong, nonatomic)NSDate *openTimestamp;

@end
