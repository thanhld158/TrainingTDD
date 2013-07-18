//
//  Account3.h
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account3 : NSObject
@property (strong, nonatomic) NSString *accountNumber;
@property (strong, nonatomic) NSNumber *balance;
@property (strong, nonatomic) NSDate *openTimeStamp;
@end
