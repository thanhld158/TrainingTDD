//
//  BankAccountDAO.h
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Account;

@interface BankAccountDAO : NSObject
- (BOOL)insertNewAccount:(Account *)newAcc;
- (Account *)getAccountWithAccountNumber:(NSString *)accountNumber;
- (BOOL )updateAccount:(Account *)account;

@property (nonatomic, strong) FMDatabaseQueue *dataAccessHelper;
@property (nonatomic, strong) NSError *error;
@end
