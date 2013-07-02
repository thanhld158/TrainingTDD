//
//  BankAccountDAO2.h
//  BankAccount
//
//  Created by Le Duy Thanh on 28/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account2.h"

@interface BankAccountDAO2 : NSObject

- (BOOL )insertNewAccount:(Account2 *)newAccount;
- (Account2 *)getAccount:(NSString *)accountNumber;
- (BOOL)updateBankAccount:(Account2 *)account;
@end
