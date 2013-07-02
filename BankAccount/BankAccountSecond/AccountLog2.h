//
//  AccountLog2.h
//  BankAccount
//
//  Created by Le Duy Thanh on 02/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountLog2 : NSObject

@property (strong, nonatomic)NSString *accountNumber;
@property (strong, nonatomic)NSDate *timestamp;
@property (strong, nonatomic)NSNumber *amount;
@property (strong, nonatomic)NSString *description;
@end
