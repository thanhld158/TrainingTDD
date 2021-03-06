//
//  BankAccount.m
//  BankAccount
//
//  Created by Le Duy Thanh on 11/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "BankAccount.h"
#import "BankAccountDAO.h"
#import "Account.h"
#import "AccountLog.h"
#import "AccountLogDAO.h"

@implementation BankAccount

@synthesize bankAccountDAO;
@synthesize bankAccountLogDAO;

-(id)initWithDAO:(BankAccountDAO *)daoObject andLogDAO:(AccountLogDAO *)logDAO{
    if (self = [super init]) {
        bankAccountDAO = daoObject;
        bankAccountLogDAO = logDAO;
    }
    return self;
}

- (Account *)createNewAccoutWithAccountNumber:(NSString *)accString {
    Account *account = [[Account alloc] init];
    account.accountNumber = accString;
    account.balance = @0;
    return account;
}

-(Account *)openAccount:(NSString *)accountNumber {
    Account *insertAcc = [self createNewAccoutWithAccountNumber:accountNumber];
    Account *resultAcc = [bankAccountDAO insertToDBWithAccount:insertAcc];
    return resultAcc;
}

-(Account *)getAccount:(NSString *)accountNumber {
    Account *acc = [bankAccountDAO getAccount:accountNumber];
    return acc;
}

- (AccountLog *)createAccountLogWithAccNumber:(NSString *)accNumber moneyAmount:(NSNumber *)amount andDes:(NSString *)des {
    AccountLog *accLog = [[AccountLog alloc] init];
    accLog.accountNumber = accNumber;
    accLog.amount = amount;
    accLog.description = des;
    NSDate *timeStamp = [NSDate date];
    accLog.timestamp = timeStamp;
    return accLog;
}

- (Account *)deposit:(NSString *)accountNumber moneyAmount:(NSNumber *)amount andDes:(NSString *)des {
    Account *accountBefore = [self getAccount:accountNumber];
    Account *accountAfter = [[Account alloc] init];
    accountAfter.accountNumber = accountBefore.accountNumber;
    accountAfter.balance = @(accountBefore.balance.doubleValue + amount.doubleValue);
    accountAfter.openTimestamp = accountBefore.openTimestamp;
    
    if ([bankAccountDAO updateAcountWithAcount:accountAfter]) {
        AccountLog *accLog = [self createAccountLogWithAccNumber:accountNumber moneyAmount:amount andDes:des];
        [bankAccountLogDAO insertToDBWithAccountLog:accLog];
    }else
        accountAfter = nil;
    
    return accountAfter;
}

- (Account *)withdraw:(NSString *)accountNumber moneyAmount:(NSNumber *)amount andDes:(NSString *)des {
    Account *accountBefore = [self getAccount:accountNumber];
    Account *accountAfter = [[Account alloc] init];
    accountAfter.accountNumber = accountBefore.accountNumber;
    accountAfter.balance = @(accountBefore.balance.doubleValue - amount.doubleValue);
    accountAfter.openTimestamp = accountBefore.openTimestamp;
    
    if ([bankAccountDAO updateAcountWithAcount:accountAfter]) {
        AccountLog *accLog = [self createAccountLogWithAccNumber:accountNumber moneyAmount:@(-amount.doubleValue) andDes:des];
        [bankAccountLogDAO insertToDBWithAccountLog:accLog];
    }else
        accountAfter = nil;
    
    return accountAfter;
}

- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber {
    NSMutableArray *transactionList = [NSMutableArray arrayWithCapacity:0];
    transactionList = [[bankAccountLogDAO getTransactionsOccurred:accountNumber] mutableCopy];
    return transactionList;
}

- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber startTime:(NSDate *)startTime stopTime:(NSDate *)stopTime {
    NSMutableArray *transactionList = [NSMutableArray arrayWithCapacity:0];
    transactionList = [[bankAccountLogDAO getTransactionsOccurred:accountNumber startTime:startTime stopTime:stopTime] mutableCopy];
    return transactionList;
}

- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber numberItem:(NSNumber *)nItem {
    NSMutableArray *transactionList = [NSMutableArray arrayWithCapacity:0];
    transactionList = [[bankAccountLogDAO getTransactionsOccurred:accountNumber numberItem:nItem] mutableCopy];
    return transactionList;
}

@end
