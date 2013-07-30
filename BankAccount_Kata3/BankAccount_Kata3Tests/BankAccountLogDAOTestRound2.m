//
//  BankAccountLogDAOTestRound2.m
//  BankAccount_Kata3
//
//  Created by Le Duy Thanh on 30/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "Kiwi.h"
#import <LocalStorage/LocalStorage.h>
#import "BankAccountLogDAO.h"
#import "AccountLog.h"

SPEC_BEGIN(BankAccountLogDAORound2)
__block DBEnviroment *env;
__block BankAccountLogDAO *sut;
__block NSString *accountNumber;

beforeEach(^{
    env = [[DBEnviroment alloc] init];
    sut = [[BankAccountLogDAO alloc] init];
    accountNumber = @"thanhld";
    sut.dataAccessHelper = env.databaseQueue;
});

afterEach(^{
    env = nil;
    sut = nil;
    accountNumber = nil;
});

describe(@"BankAccountLogDAORound2", ^{
    context(@"Test insert transaction", ^{
        it(@"Insert into empty database, expect result will success", ^{
            // Prepare enviroment
            AccountLog *accWillInsert = [[AccountLog alloc] init];
            accWillInsert.accountNumber = accountNumber;
            accWillInsert.amount = @(100);
            accWillInsert.timestamp = [NSDate date];
            accWillInsert.description = @"thanhld";
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            // Perform
            BOOL insertSuccess = [sut insertAccountLogForTransaction:accWillInsert];
            
            // Test
            [[theValue(insertSuccess) should] equal:theValue(YES)];
        });
    });
    
    context(@"Get all transaction with given account number", ^{
        it(@"There's no transaction with given account number", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *accLogArray = [sut getTransactionsOccurredWithAccountNumber:accountNumber];
            [[theValue(accLogArray.count) should] equal:theValue(0)];
        });
        
        it(@"There's some transactions with given account number, result should equal 5", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *accLogArray = [sut getTransactionsOccurredWithAccountNumber:accountNumber];
            [[theValue(accLogArray.count) should] equal:theValue(5)];
        });
        
        it(@"There's some transactions but there's no transaction with given account number, result should equal 0", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *accLogArray = [sut getTransactionsOccurredWithAccountNumber:@"12345"];
            [[theValue(accLogArray.count) should] equal:theValue(0)];
        });
    });
    
    context(@"Get all transaction with given account number, start time, end time", ^{
        it(@"There're some transactions with given account number but timeOpened is not into between start time and end time.", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSString *startTime = @"2012-01-01 12:12:06";
            NSString *stopTime = @"2012-01-01 12:12:10";
            NSDateFormatter *datefomater = [[NSDateFormatter alloc] init];
            [datefomater setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            NSDate *startDate = [datefomater dateFromString:startTime];
            NSDate *stopDate = [datefomater dateFromString:stopTime];
            
            
            NSArray *accLogArray = [sut getTransactionsOccurredWithAccountNumber:accountNumber startTime:startDate andStopTime:stopDate];
            [[theValue(accLogArray.count) should] equal:theValue(0)];
        });
        
        it(@"There're some transactions with given account number but timeOpened is into between start time and end time, result should equal 3", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc4" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSString *startTime = @"2012-01-01 12:12:13";
            NSString *stopTime = @"2012-01-01 12:12:18";
            NSDateFormatter *datefomater = [[NSDateFormatter alloc] init];
            [datefomater setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            NSDate *startDate = [datefomater dateFromString:startTime];
            NSDate *stopDate = [datefomater dateFromString:stopTime];
            
            
            NSArray *accLogArray = [sut getTransactionsOccurredWithAccountNumber:accountNumber startTime:startDate andStopTime:stopDate];
            [[theValue(accLogArray.count) should] equal:theValue(3)];
        });
    });
    
    context(@"Get n newest transaction with given account number.", ^{
        it(@"Total transactions with given number is less than n. There're 5 trans in db, result should return 5", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc4" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut getTransactionsOccurredWithAccountNumber:accountNumber andNumberTransaction:10];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(5)];
        });
        
        it(@"Total transactions with given number is more than  or equal n. result should return 10", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc5" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut getTransactionsOccurredWithAccountNumber:accountNumber andNumberTransaction:10];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(10)];
        });
    });
});

SPEC_END