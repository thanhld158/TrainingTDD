//
//  BankAccountLogDAO2.h
//  BankAccount
//
//  Created by Le Duy Thanh on 03/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountLog2.h"

@interface BankAccountLogDAO2 : NSObject

- (BOOL)insertAccountLog:(AccountLog2 *)accLog;
@end
