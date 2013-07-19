//
//  BankAccount.h
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BankAccountDAO, BankAccountLogDAO, AccountLog, Account;
@interface BankAccount : NSObject

@property(strong, nonatomic)BankAccountDAO *bankAccountDAO;
@property(strong, nonatomic)BankAccountLogDAO *bankAccountLogDAO;

- (Account *)open:(NSString *)accountNumber;
- (Account *)getAccount:(NSString *)accountNumber;
- (AccountLog *)createAccLogWithAccountNumber:(NSString *)accNumber amount:(NSNumber *)amount andDes:(NSString *)des;
- (Account *)deposit:(NSString *)accountNumber amount:(NSNumber *)amount andDes:(NSString *)des;
- (Account *)withdraw:(NSString *)accountNumber amount:(NSNumber *)amount andDes:(NSString *)des;
- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber;
- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber startTime:(NSDate *)startTime andStopTime:(NSDate *)stopTime;
- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber andNumberTransaction:(NSInteger )numberTransaction;
@end
