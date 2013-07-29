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
        it(@"insert into an empty database", ^{
            Account *accountWillInsert = [[Account alloc] init];
            accountWillInsert.accountNumber = accNumber;
            accountWillInsert.balance = @0;
            accountWillInsert.openTimeStamp = [NSDate date];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc1" ofType:@"sql"];
            BOOL loadScriptSuccess = [env loadScriptFile:scriptFilePath];
            
            if (loadScriptSuccess) {
                BOOL val = [sut insertNewAccount:accountWillInsert];
                [[theValue(val) should] equal:theValue(YES)];
            }else
                NSLog(@"Load script file is fail");
        });
        
        it(@"insert into which's accountnumber is exists", ^{
            Account *accountWillInsert = [[Account alloc] init];
            accountWillInsert.accountNumber = accNumber;
            accountWillInsert.balance = @0;
            accountWillInsert.openTimeStamp = [NSDate date];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc2" ofType:@"sql"];
            BOOL loadScriptSuccess = [env loadScriptFile:scriptFilePath];
            
            if (loadScriptSuccess) {
                BOOL val = [sut insertNewAccount:accountWillInsert];
                [[theValue(val) should] equal:theValue(NO)];
            }else
                NSLog(@"Load script file is fail");
        });
    });
    
    context(@"Test get account with account number given", ^{
        it(@"There's no account in db", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            Account *accountGet = [sut getAccountWithAccountNumber:accNumber];
            [accountGet shouldBeNil];
            [sut.error shouldNotBeNil];
        });
        
        it(@"There's no account in db which has account number like account number given", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc3" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            Account *accountGet = [sut getAccountWithAccountNumber:accNumber];
            [accountGet shouldBeNil];
            [sut.error shouldNotBeNil];
        });
        
        it(@"get account, there's account with given account number in database", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            Account *accountGet = [sut getAccountWithAccountNumber:accNumber];
            [accountGet shouldNotBeNil];
            [[accountGet.accountNumber should] equal:accNumber];
            [sut.error shouldBeNil];
        });
    });
    
    context(@"Test update account", ^{
        it(@"Update account that is exists in database", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            Account *accountBeforeUpdate = [sut getAccountWithAccountNumber:accNumber];
            accountBeforeUpdate.balance = @(accountBeforeUpdate.balance.doubleValue + 50.f);
            
            BOOL val = [sut updateAccount:accountBeforeUpdate];
            [[theValue(val) should] equal:theValue(YES)];
        });
    });
    
});
SPEC_END