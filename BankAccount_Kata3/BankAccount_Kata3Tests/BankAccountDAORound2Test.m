//
//  BankAccountDAORound2Test.m
//  BankAccount_Kata3
//
//  Created by Le Duy Thanh on 30/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "Kiwi.h"
#import "BankAccountDAO.h"
#import <LocalStorage/LocalStorage.h>
#import "Account.h"

SPEC_BEGIN(BankAccountDAOTestRound2)

describe(@"BankAccountDAOTestRound2", ^{
    __block DBEnviroment *env;
    __block BankAccountDAO *sut;
    __block NSString *accountNumber;
    
    beforeEach(^{
        env = [[DBEnviroment alloc] init];
        sut = [[BankAccountDAO alloc] init];
        accountNumber = @"thanhld";
        sut.dataAccessHelper = env.databaseQueue;
    });
    
    afterEach(^{
        env = nil;
        sut = nil;
        accountNumber = nil;
    });
    
    context(@"Test insert", ^{
        it(@"Insert account into an empty db, expect result will success", ^{
            // Prepare enviroment
            Account *accWillInsert = [[Account alloc] init];
            accWillInsert.accountNumber = accountNumber;
            accWillInsert.balance = @(0);
            accWillInsert.openTimeStamp = [NSDate date];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            // Perform
            BOOL insertSuccess = [sut insertNewAccount:accWillInsert];
            
            // Test
            [[theValue(insertSuccess) should] equal:theValue(YES)];
        });
        
        it(@"Insert account with an accountNumber which has exists, expect result will fail", ^{
            // Prepare enviroment
            Account *accWillInsert = [[Account alloc] init];
            accWillInsert.accountNumber = accountNumber;
            accWillInsert.balance = @(0);
            accWillInsert.openTimeStamp = [NSDate date];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            // Perform
            BOOL insertSuccess = [sut insertNewAccount:accWillInsert];
            
            // Test
            [[theValue(insertSuccess) should] equal:theValue(NO)];
        });
    });
    
    context(@"Test get an account with accountNumber", ^{
        it(@"There's no account in db, expect result will fail", ^{
            // Prepare enviroment
            Account *accountReturn = nil;
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            // Perform
            accountReturn = [sut getAccountWithAccountNumber:accountNumber];
            
            // Test
            [accountReturn shouldBeNil];
            [sut.error shouldNotBeNil];
        });
        
        it(@"There's no account in db which has account number like account number given, expect result will fail", ^{
            // Prepare enviroment
            Account *accountReturn = nil;
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc3" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            // Perform
            accountReturn = [sut getAccountWithAccountNumber:accountNumber];
            
            // Test
            [accountReturn shouldBeNil];
            [sut.error shouldNotBeNil];
        });
        
        it(@"There is account with account number given, expect result will success", ^{
            // Prepare enviroment
            Account *accountReturn = nil;
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            // Perform
            accountReturn = [sut getAccountWithAccountNumber:accountNumber];
            
            // Test
            [accountReturn shouldNotBeNil];
            [sut.error shouldBeNil];
        });
    });
    
    context(@"Test update account", ^{
        it(@"Update account that is exists in database.", ^{
            // Prepare enviroment
            Account *accWillUpdated = [[Account alloc] init];
            accWillUpdated.accountNumber = accountNumber;
            accWillUpdated.balance = @(200);
            accWillUpdated.openTimeStamp = [NSDate date];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            // Perform
            BOOL insertSuccess = [sut updateAccount:accWillUpdated];
            
            // Test
            [[theValue(insertSuccess) should] equal:theValue(YES)];
            Account *accAfterUpdated = [sut getAccountWithAccountNumber:accountNumber];
            [[accAfterUpdated.balance should] equal:@(200)];
        });
    });
    
});

SPEC_END