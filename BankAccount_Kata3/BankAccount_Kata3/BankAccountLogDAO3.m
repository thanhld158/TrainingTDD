//
//  BankAccountLogDAO3.m
//  BankAccount
//
//  Created by Le Duy Thanh on 09/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "BankAccountLogDAO3.h"
#import "AccountLog3.h"

@implementation BankAccountLogDAO3

- (BOOL)insertAccountLogForTransaction:(AccountLog3 *)accLog {
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
