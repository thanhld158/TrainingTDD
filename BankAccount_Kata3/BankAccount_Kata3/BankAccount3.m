//
//  BankAccount3.m
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "BankAccount3.h"
#import "Account3.h"
#import "BankAccountDAO3.h"
#import "AccountLog3.h"
#import "BankAccountLogDAO3.h"

@implementation BankAccount3
@synthesize bankAccountDAO;
@synthesize bankAccountLogDAO;

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

- (AccountLog3 *)createAccLogWithAccountNumber:(NSString *)accNumber amount:(NSNumber *)amount andDes:(NSString *)des {
    AccountLog3 *accLog = [[AccountLog3 alloc] init];
    accLog.accountNumber = accNumber;
    NSDate *timestamp = [NSDate date];
    accLog.timestamp = timestamp;
    accLog.amount = amount;
    accLog.description = des;
    return accLog;
}

- (Account3 *)deposit:(NSString *)accountNumber amount:(NSNumber *)amount andDes:(NSString *)des {
    Account3 *accountBeforeDeposit = [self getAccount:accountNumber];
    Account3 *accountAfterDeposit = [[Account3 alloc] init];
    accountAfterDeposit.accountNumber = accountNumber;
    accountAfterDeposit.openTimeStamp = accountBeforeDeposit.openTimeStamp;
    accountAfterDeposit.balance = @(accountBeforeDeposit.balance.doubleValue + amount.doubleValue);
    if ([bankAccountDAO updateAccount:accountAfterDeposit]) {
        AccountLog3 *accLog = [self createAccLogWithAccountNumber:accountNumber amount:amount andDes:des];
        [bankAccountLogDAO insertAccountLogForTransaction:accLog];
        return accountAfterDeposit;
    }
    return nil;
}

- (Account3 *)withdraw:(NSString *)accountNumber amount:(NSNumber *)amount andDes:(NSString *)des {
    Account3 *accountBeforeWithdraw = [self getAccount:accountNumber];
    Account3 *accountAfterWithdraw = [[Account3 alloc] init];
    accountAfterWithdraw.accountNumber = accountNumber;
    accountAfterWithdraw.openTimeStamp = accountBeforeWithdraw.openTimeStamp;
    accountAfterWithdraw.balance = @(accountBeforeWithdraw.balance.doubleValue - amount.doubleValue);
    if ([bankAccountDAO updateAccount:accountAfterWithdraw]) {
        AccountLog3 *accLog = [self createAccLogWithAccountNumber:accountNumber amount:@(-amount.doubleValue) andDes:des];
        [bankAccountLogDAO insertAccountLogForTransaction:accLog];
        return accountAfterWithdraw;
    }
    return nil;
}

- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber {
    NSArray *logTransactionList = [bankAccountLogDAO getTransactionsOccurredWithAccountNumber:accountNumber];
    return logTransactionList;
}

- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber startTime:(NSDate *)startTime andStopTime:(NSDate *)stopTime {
    NSArray *logTransactionList = [bankAccountLogDAO getTransactionsOccurredWithAccountNumber:accountNumber startTime:startTime andStopTime:stopTime];
    return logTransactionList;
}

- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber andNumberTransaction:(NSInteger )numberTransaction {
    NSArray *logTransactionList = [bankAccountLogDAO getTransactionsOccurredWithAccountNumber:accountNumber andNumberTransaction:numberTransaction];
    return logTransactionList;
}
@end
