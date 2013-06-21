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

-(id)initWithDAO:(BankAccountDAO *)daoObject andLogDAO:(AccountLogDAO *)accountLogDAO;

@property (nonatomic, strong) BankAccountDAO *bankAccountDAO;
@property (nonatomic, strong) AccountLogDAO *accountLogDAO;

-(Account *)openAccount:(NSString *)accountNumber;
- (Account *)createNewAccoutWithAccountNumber:(NSString *)accString;
- (Account *)getAccount:(NSString *)accountNumber;
- (Account *)deposit:(NSString *)accountNumber moneyAmount:(NSNumber *)amount andDes:(NSString *)des;

@end
