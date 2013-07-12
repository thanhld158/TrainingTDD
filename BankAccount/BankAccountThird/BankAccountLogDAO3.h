//
//  BankAccountLogDAO3.h
//  BankAccount
//
//  Created by Le Duy Thanh on 09/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountLog3.h"

@interface BankAccountLogDAO3 : NSObject
- (BOOL)insertAccountLogForTransaction:(AccountLog3 *)accLog;
- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber;
- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber startTime:(NSDate *)startTime andStopTime:(NSDate *)stopTime;
- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber andNumberTransaction:(NSInteger )numberTransaction;
@end
