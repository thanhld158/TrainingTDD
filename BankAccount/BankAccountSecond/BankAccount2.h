//
//  BankAccount2.h
//  BankAccount
//
//  Created by Le Duy Thanh on 28/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankAccountDAO2.h"
#import "Account2.h"

@interface BankAccount2 : NSObject

@property (strong, nonatomic)BankAccountDAO2 *bankAccountDAO;

- (Account2 *)open:(NSString *)accountNumber;
- (Account2 *)getAccount:(NSString *)accountNumber;
- (Account2 *)deposit:(NSString *)accountNumber amount:(NSNumber *)amount andDescription:(NSString *)des;
@end
