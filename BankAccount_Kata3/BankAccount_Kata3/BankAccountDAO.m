//
//  BankAccountDAO.m
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "BankAccountDAO.h"
#import "Account.h"

@implementation BankAccountDAO
@synthesize dataAccessHelper;
@synthesize error;

- (BOOL)insertNewAccount:(Account *)newAcc {
    __block BOOL val;
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *dateOpended = [dateformat stringFromDate:newAcc.openTimeStamp];
        
        NSString *stm = [NSString stringWithFormat:@"insert into Account(accountnumber,balance,openTimeStamp) values('%@', %@, '%@')", newAcc.accountNumber, newAcc.balance, dateOpended];
        val = [db executeUpdate:stm];
    }];
    return val;
}

- (Account *)getAccountWithAccountNumber:(NSString *)accountNumber {
    return nil;
}

- (BOOL )updateAccount:(Account *)account {
    return NO;
}
@end
