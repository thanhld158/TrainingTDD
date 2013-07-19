//
//  BankAccount.m
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "BankAccount.h"
#import "Account.h"
#import "BankAccountDAO.h"
#import "AccountLog.h"
#import "BankAccountLogDAO.h"

@implementation BankAccount
@synthesize bankAccountDAO;
@synthesize bankAccountLogDAO;

- (Account *)open:(NSString *)accountNumber {
    Account *newAccount = [[Account alloc] init];
    newAccount.accountNumber = accountNumber;
    newAccount.balance = @(0);
    newAccount.openTimeStamp = [NSDate date];
    
    if ([bankAccountDAO insertNewAccount:newAccount]) {
        return newAccount;
    }
    return nil;
}

- (Account *)getAccount:(NSString *)accountNumber {
    Account *accountReturn;
    accountReturn = [bankAccountDAO getAccountWithAccountNumber:accountNumber];
    return accountReturn;
}

- (AccountLog *)createAccLogWithAccountNumber:(NSString *)accNumber amount:(NSNumber *)amount andDes:(NSString *)des {
    AccountLog *accLog = [[AccountLog alloc] init];
    accLog.accountNumber = accNumber;
    NSDate *timestamp = [NSDate date];
    accLog.timestamp = timestamp;
    accLog.amount = amount;
    accLog.description = des;
    return accLog;
}

- (Account *)deposit:(NSString *)accountNumber amount:(NSNumber *)amount andDes:(NSString *)des {
    Account *accountBeforeDeposit = [self getAccount:accountNumber];
    Account *accountAfterDeposit = [[Account alloc] init];
    accountAfterDeposit.accountNumber = accountNumber;
    accountAfterDeposit.openTimeStamp = accountBeforeDeposit.openTimeStamp;
    accountAfterDeposit.balance = @(accountBeforeDeposit.balance.doubleValue + amount.doubleValue);
    if ([bankAccountDAO updateAccount:accountAfterDeposit]) {
        AccountLog *accLog = [self createAccLogWithAccountNumber:accountNumber amount:amount andDes:des];
        [bankAccountLogDAO insertAccountLogForTransaction:accLog];
        return accountAfterDeposit;
    }
    return nil;
}

- (Account *)withdraw:(NSString *)accountNumber amount:(NSNumber *)amount andDes:(NSString *)des {
    Account *accountBeforeWithdraw = [self getAccount:accountNumber];
    Account *accountAfterWithdraw = [[Account alloc] init];
    accountAfterWithdraw.accountNumber = accountNumber;
    accountAfterWithdraw.openTimeStamp = accountBeforeWithdraw.openTimeStamp;
    accountAfterWithdraw.balance = @(accountBeforeWithdraw.balance.doubleValue - amount.doubleValue);
    if ([bankAccountDAO updateAccount:accountAfterWithdraw]) {
        AccountLog *accLog = [self createAccLogWithAccountNumber:accountNumber amount:@(-amount.doubleValue) andDes:des];
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
