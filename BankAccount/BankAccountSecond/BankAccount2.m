//
//  BankAccount2.m
//  BankAccount
//
//  Created by Le Duy Thanh on 28/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "BankAccount2.h"
#import "Account2.h"
#import "AccountLog2.h"

@implementation BankAccount2
@synthesize bankAccountDAO;
@synthesize bankAccountLogDAO;

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

- (AccountLog2 *)createAccountLogWithAccountNumber:(NSString *)accountNumber amount:(NSNumber *)amount
                                            andDes:(NSString *)des {
    AccountLog2 *accLog = [[AccountLog2 alloc] init];
    accLog.accountNumber = accountNumber;
    accLog.amount = amount;
    accLog.description = des;
    NSDate *timestamp = [NSDate date];
    accLog.timestamp = timestamp;
    return accLog;
}

- (Account2 *)deposit:(NSString *)accountNumber amount:(NSNumber *)amount andDescription:(NSString *)des {
    Account2 *accBefore = [self getAccount:accountNumber];
    Account2 *accAfter = [[Account2 alloc] init];
    accAfter.accountNumber = accountNumber;
    accAfter.openTimestamp = accBefore.openTimestamp;
    accAfter.balance = @(accBefore.balance.doubleValue + amount.doubleValue);
    
    if ([bankAccountDAO updateBankAccount:accAfter]) {
        AccountLog2 *accLog = [self createAccountLogWithAccountNumber:accountNumber amount:amount andDes:des];
        [bankAccountLogDAO insertAccountLog:accLog];
        return accAfter;
    }
    return nil;
}

- (Account2 *)withdraw:(NSString *)accountNumber amount:(NSNumber *)amount andDescription:(NSString *)des {
    Account2 *accBefore = [self getAccount:accountNumber];
    Account2 *accAfter = [[Account2 alloc] init];
    accAfter.accountNumber = accountNumber;
    accAfter.openTimestamp = accBefore.openTimestamp;
    accAfter.balance = @(accBefore.balance.doubleValue - amount.doubleValue);
    
    if ([bankAccountDAO updateBankAccount:accAfter]) {
        AccountLog2 *accLog = [self createAccountLogWithAccountNumber:accountNumber amount:amount andDes:des];
        [bankAccountLogDAO insertAccountLog:accLog];
        return accAfter;
    }
    return nil;
}

- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber {
    NSArray *transactionList = [bankAccountLogDAO getTransactionsOccurredWithAccountNumber:accountNumber];
    return transactionList;
}

- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber startTime:(NSDate *)startTime stopTime:(NSDate *)stopTime {
    NSArray *transactionList = [bankAccountLogDAO getTransactionsOccurredWithAccountNumber:accountNumber startTime:startTime stopTime:stopTime];
    return transactionList;
}

@end
