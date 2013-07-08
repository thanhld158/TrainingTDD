//
//  BankAccount3.h
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account3.h"
#import "BankAccountDAO3.h"

@interface BankAccount3 : NSObject

@property(strong, nonatomic)BankAccountDAO3 *bankAccountDAO;

- (Account3 *)open:(NSString *)accountNumber;
- (Account3 *)getAccount:(NSString *)accountNumber;
@end
