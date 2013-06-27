//
//  BankAccount.h
//  BankAccount
//
//  Created by Le Duy Thanh on 11/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountLogDAO.h"
@class BankAccountDAO;
@class Account;

@interface BankAccount : NSObject

-(id)initWithDAO:(BankAccountDAO *)daoObject andLogDAO:(AccountLogDAO *)bankAccountLogDAO;

@property (nonatomic, strong) BankAccountDAO *bankAccountDAO;
@property (nonatomic, strong) AccountLogDAO *bankAccountLogDAO;

-(Account *)openAccount:(NSString *)accountNumber;
- (Account *)createNewAccoutWithAccountNumber:(NSString *)accString;
- (Account *)getAccount:(NSString *)accountNumber;
- (Account *)deposit:(NSString *)accountNumber moneyAmount:(NSNumber *)amount andDes:(NSString *)des;
- (AccountLog *)createAccountLogWithAccNumber:(NSString *)accNumber moneyAmount:(NSNumber *)amount andDes:(NSString *)des;
- (Account *)withdraw:(NSString *)accountNumber moneyAmount:(NSNumber *)amount andDes:(NSString *)des;
- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber;
- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber startTime:(NSDate *)startTime stopTime:(NSDate *)stopTime;
- (NSArray *)getTransactionsOccurred:(NSString *)accountNumber numberItem:(NSNumber *)nItem;
@end
