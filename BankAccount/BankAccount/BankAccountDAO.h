//
//  BankAccountDAO.h
//  BankAccount
//
//  Created by Le Duy Thanh on 12/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Account;

@interface BankAccountDAO : NSObject

-(Account *)insertToDBWithAccount:(Account *)insertAcc;

- (Account *)getAccount:(NSString *)accountNumber;

- (BOOL)updateAcountWithAcount:(Account *)acc;
@end
