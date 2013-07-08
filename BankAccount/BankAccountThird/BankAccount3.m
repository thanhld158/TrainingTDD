//
//  BankAccount3.m
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "BankAccount3.h"

@implementation BankAccount3
@synthesize bankAccountDAO;

- (Account3 *)open:(NSString *)accountNumber {
    Account3 *newAccount = [[Account3 alloc] init];
    newAccount.accountNumber = accountNumber;
    newAccount.balance = @(0);
    newAccount.openTimeStamp = [NSDate date];
    
    if ([bankAccountDAO insertNewAccount:newAccount]) {
        return newAccount;
    }
    return nil;
}

- (Account3 *)getAccount:(NSString *)accountNumber {
    Account3 *accountReturn;
    accountReturn = [bankAccountDAO getAccountWithAccountNumber:accountNumber];
    return accountReturn;
}
@end
