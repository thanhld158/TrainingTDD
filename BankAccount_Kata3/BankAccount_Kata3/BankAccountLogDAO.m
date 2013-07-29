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
@synthesize dataAccessHelper;

- (BOOL)insertAccountLogForTransaction:(AccountLog *)accLog {
    __block BOOL val;
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *dateOpended = [dateformat stringFromDate:accLog.timestamp];
        
        NSString *stm = [NSString stringWithFormat:@"insert into BankAccountLog(accountNumber,amount,timestamp) values('%@', %@, '%@')", accLog.accountNumber, accLog.amount, dateOpended];
        val = [db executeUpdate:stm];
    }];
    return val;
}

- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber {
    __block NSMutableArray *tranResult = [[NSMutableArray alloc] init];
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *stm = [NSString stringWithFormat:@"select * from BankAccountLog where accountNumber = '%@'", accountNumber];
        
        FMResultSet *rs = [db executeQuery:stm];
        while ([rs next]) {
            AccountLog *accLog = [[AccountLog alloc] init];
            accLog.accountNumber = [rs objectForColumnName:@"accountNumber"];
            accLog.amount = [rs objectForColumnName:@"amount"];
            accLog.timestamp = [rs objectForColumnName:@"timestamp"];
            accLog.description = [rs objectForColumnName:@"description"];
            [tranResult addObject:accLog];
        }
    }];
    return tranResult;
}

- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber
                                            startTime:(NSDate *)startTime
                                          andStopTime:(NSDate *)stopTime {
    __block NSMutableArray *tranResult = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *startTimeStr = [dateFormatter stringFromDate:startTime];
    NSString *stopTimeStr = [dateFormatter stringFromDate:stopTime];
    
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *stm = [NSString stringWithFormat:@"select * from BankAccountLog where accountNumber = '%@' and timestamp > '%@' and timestamp < '%@'", accountNumber, startTimeStr, stopTimeStr];
        
        FMResultSet *rs = [db executeQuery:stm];
        while ([rs next]) {
            AccountLog *accLog = [[AccountLog alloc] init];
            accLog.accountNumber = [rs objectForColumnName:@"accountNumber"];
            accLog.amount = [rs objectForColumnName:@"amount"];
            accLog.timestamp = [rs objectForColumnName:@"timestamp"];
            accLog.description = [rs objectForColumnName:@"description"];
            [tranResult addObject:accLog];
        }
    }];
    return tranResult;
}

- (NSArray *)getTransactionsOccurredWithAccountNumber:(NSString *)accountNumber andNumberTransaction:(NSInteger )numberTransaction {
    __block NSMutableArray *tranResult = [[NSMutableArray alloc] init];
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *stm = [NSString stringWithFormat:@"select * from BankAccountLog where accountNumber = '%@' order by timestamp DESC LIMIT %d", accountNumber, numberTransaction];
        
        FMResultSet *rs = [db executeQuery:stm];
        while ([rs next]) {
            AccountLog *accLog = [[AccountLog alloc] init];
            accLog.accountNumber = [rs objectForColumnName:@"accountNumber"];
            accLog.amount = [rs objectForColumnName:@"amount"];
            accLog.timestamp = [rs objectForColumnName:@"timestamp"];
            accLog.description = [rs objectForColumnName:@"description"];
            [tranResult addObject:accLog];
        }
    }];
    return tranResult;
}
@end
