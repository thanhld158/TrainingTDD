//
//  BankAccountLogDAO.h
//  BankAccount
//
//  Created by Le Duy Thanh on 09/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AccountLog;

@interface BankAccountLogDAO : NSObject

@property (nonatomic, strong) FMDatabaseQueue *dataAccessHelper;

- (BOOL)insertAccountLogForTransaction:(AccountLog *)accLog;
- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber;
- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber startTime:(NSDate *)startTime andStopTime:(NSDate *)stopTime;
- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber andNumberTransaction:(NSInteger )numberTransaction;
@end
