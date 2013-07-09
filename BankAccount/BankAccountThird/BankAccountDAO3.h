//
//  BankAccountDAO3.h
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account3.h"

@interface BankAccountDAO3 : NSObject
- (BOOL)insertNewAccount:(Account3 *)newAcc;
- (Account3 *)getAccountWithAccountNumber:(NSString *)accountNumber;
- (BOOL )updateAccount:(Account3 *)account;
@end
