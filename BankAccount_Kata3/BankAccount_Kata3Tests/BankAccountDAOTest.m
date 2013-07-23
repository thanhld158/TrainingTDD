//
//  BankAccountDAOTest.m
//  BankAccount
//
//  Created by Le Duy Thanh on 16/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "Kiwi.h"
#import "BankAccountDAO.h"
#import <LocalStorage/LocalStorage.h>

SPEC_BEGIN(BankAccountDAOTest)
describe(@"BankAccountDAOTest", ^{
    __block DBEnviroment *env;
    __block BankAccountDAO *sut;
    __block NSString *accNumber;
    
    beforeEach(^{
        env = [[DBEnviroment alloc] init];
        sut = [[BankAccountDAO alloc] init];
        sut.dataAccessHelper = env.databaseQueue;
        accNumber = @"1234567890";
    });
    
    afterEach(^{
        env = nil;
        sut = nil;
        accNumber = nil;
    });
    
    it(@"<#string#>", <#^(void)aBlock#>)
});
SPEC_END