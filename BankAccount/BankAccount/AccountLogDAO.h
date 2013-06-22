//
//  AccountLogDAO.h
//  BankAccount
//
//  Created by Le Duy Thanh on 21/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountLog.h"

@interface AccountLogDAO : NSObject

- (AccountLog *)insertToDBWithAccountLog:(AccountLog *)accLog;
@end
