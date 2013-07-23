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
#import "Account.h"

SPEC_BEGIN(BankAccountDAOTest)
describe(@"BankAccountDAOTest", ^{
    __block DBEnviroment *env;
    __block BankAccountDAO *sut;
    __block NSString *accNumber;
    
    beforeEach(^{
        env = [[DBEnviroment alloc] init];
        sut = [[BankAccountDAO alloc] init];
        sut.dataAccessHelper = env.databaseQueue;
        accNumber = @"thanhld";
    });
    
    afterEach(^{
        env = nil;
        sut = nil;
        accNumber = nil;
    });
    
    context(@"insert new account", ^{
        it(@"insert into empty database should success", ^{
            Account *accountWillInsert = [[Account alloc] init];
            accountWillInsert.accountNumber = accNumber;
            accountWillInsert.balance = @0;
            accountWillInsert.openTimeStamp = [NSDate date];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            BOOL val = [sut insertNewAccount:accountWillInsert];
            [[theValue(val) should] equal:theValue(YES)];
        });
        
        it(@"insert into which's accountnumber is exists", ^{
            Account *accountWillInsert = [[Account alloc] init];
            accountWillInsert.accountNumber = accNumber;
            accountWillInsert.balance = @0;
            accountWillInsert.openTimeStamp = [NSDate date];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            BOOL val = [sut insertNewAccount:accountWillInsert];
            [[theValue(val) should] equal:theValue(NO)];
        });
    });
});
SPEC_END