//
//  BankAccount3.h
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BankAccountDAO3, BankAccountLogDAO3, AccountLog3, Account3;
@interface BankAccount3 : NSObject

@property(strong, nonatomic)BankAccountDAO3 *bankAccountDAO;
@property(strong, nonatomic)BankAccountLogDAO3 *bankAccountLogDAO;

- (Account3 *)open:(NSString *)accountNumber;
- (Account3 *)getAccount:(NSString *)accountNumber;
- (AccountLog3 *)createAccLogWithAccountNumber:(NSString *)accNumber amount:(NSNumber *)amount andDes:(NSString *)des;
- (Account3 *)deposit:(NSString *)accountNumber amount:(NSNumber *)amount andDes:(NSString *)des;
- (Account3 *)withdraw:(NSString *)accountNumber amount:(NSNumber *)amount andDes:(NSString *)des;
- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber;
- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber startTime:(NSDate *)startTime andStopTime:(NSDate *)stopTime;
- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber andNumberTransaction:(NSInteger )numberTransaction;
@end
