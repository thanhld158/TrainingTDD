//
//  BankAccountLogDAO.m
//  BankAccount
//
//  Created by Le Duy Thanh on 09/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "BankAccountLogDAO.h"
#import "AccountLog.h"

@implementation BankAccountLogDAO

- (BOOL)insertAccountLogForTransaction:(AccountLog *)accLog {
    return NO;
}

- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber {
    return nil;
}

- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber
                                            startTime:(NSDate *)startTime
                                          andStopTime:(NSDate *)stopTime {
    return nil;
}

- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber andNumberTransaction:(NSInteger )numberTransaction {
    return nil;
}
@end
