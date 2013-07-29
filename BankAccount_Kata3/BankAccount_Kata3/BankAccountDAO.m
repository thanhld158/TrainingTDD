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
        
        NSString *stm = [NSString stringWithFormat:@"insert into Account(accountNumber,balance,openTimeStamp) values('%@', %@, '%@')", newAcc.accountNumber, newAcc.balance, dateOpended];
        val = [db executeUpdate:stm];
    }];
    return val;
}

- (Account *)getAccountWithAccountNumber:(NSString *)accountNumber {
    __block Account *accountReturn;
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *stm = [NSString stringWithFormat:@"select * from Account where accountNumber = '%@'", accountNumber];
        FMResultSet *r = [db executeQuery:stm];
        if ([r next]) {
            accountReturn = [[Account alloc] init];
            accountReturn.accountNumber = [r objectForColumnName:@"accountNumber"];
            accountReturn.balance = [r objectForColumnName:@"balance"];
            accountReturn.openTimeStamp = [r objectForColumnName:@"openTimeStamp"];
            error = nil;
        } else {
            error = [NSError errorWithDomain:@"GetAccountError" code:0 userInfo:nil];
        }
    }];
    return accountReturn;
}

- (BOOL )updateAccount:(Account *)account {
    __block BOOL val;
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *stm = [NSString stringWithFormat:@"update account set balance = %@ where accountnumber = '%@'", account.balance, account.accountNumber];
        val = [db executeUpdate:stm];
    }];
    return val;
}
@end
