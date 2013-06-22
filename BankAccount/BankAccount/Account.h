//
//  Account.h
//  BankAccount
//
//  Created by Le Duy Thanh on 12/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountLog.h"

@interface Account : NSObject

@property (strong, nonatomic) NSString *accountNumber;
@property (strong, nonatomic) NSNumber *balance;
@property (strong, nonatomic) NSString *openTimestamp;
@end
