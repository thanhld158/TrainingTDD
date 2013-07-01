//
//  BankAccount2.m
//  BankAccount
//
//  Created by Le Duy Thanh on 28/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "BankAccount2.h"
#import "Account2.h"

@implementation BankAccount2
@synthesize bankAccountDAO;

- (Account2 *)open:(NSString *)accountNumber {
    Account2 *newAcc = [[Account2 alloc] init];
    newAcc.accountNumber = accountNumber;
    newAcc.balance = @(0);
    NSDate *openDate = [NSDate date];
    newAcc.openTimestamp = openDate;
    if ([bankAccountDAO insertNewAccount:newAcc]) {
        return newAcc;
    }
    return nil;
}

- (Account2 *)getAccount:(NSString *)accountNumber {
    Account2 *accInfo;
    accInfo = [bankAccountDAO getAccount:accountNumber];
    return accInfo;
}

@end
