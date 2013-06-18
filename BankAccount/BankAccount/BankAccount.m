//
//  BankAccount.m
//  BankAccount
//
//  Created by Le Duy Thanh on 11/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "BankAccount.h"
#import "BankAccountDAO.h"
#import "Account.h"

@implementation BankAccount

@synthesize bankAccountDAO;

-(id)initWithDAO:(BankAccountDAO *)daoObject {
    if (self = [super init]) {
        bankAccountDAO = daoObject;
    }
    return self;
}

- (Account *)createNewAccoutWithAccountNumber:(NSString *)accString {
    Account *account = [[Account alloc] init];
    account.accountNumber = accString;
    account.balance = @0;
    return account;
}

-(Account *)openAccount:(NSString *)accountNumber {
    Account *insertAcc = [self createNewAccoutWithAccountNumber:accountNumber];
    Account *resultAcc = [bankAccountDAO insertToDBWithAccount:insertAcc];
    return resultAcc;
}

-(Account *)getAccount:(NSString *)accountNumber {
    Account *acc = [bankAccountDAO getAccount:accountNumber];
    return acc;
}

- (Account *)deposit:(NSString *)accountNumber moneyAmount:(NSNumber *)amount andDes:(NSString *)des {
    NSDictionary *accdict = [bankAccountDAO deposit:accountNumber moneyAmount:amount andDes:des];
    Account *accAfter = [accdict objectForKey:@"accountAfter"];
    return accAfter;
}

@end
