//
//  BankAccountLogDAOTest.m
//  BankAccount
//
//  Created by Le Duy Thanh on 16/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "Kiwi.h"
#import <LocalStorage/LocalStorage.h>
#import "BankAccountLogDAO.h"
#import "AccountLog.h"

SPEC_BEGIN(BankAccountLogDAOTest)
describe(@"BankAccountLogDAOTest", ^{
    __block DBEnviroment *env;
    __block BankAccountLogDAO *sut;
    __block NSString *accNumber;
    
    beforeEach(^{
        env = [[DBEnviroment alloc] init];
        sut = [[BankAccountLogDAO alloc] init];
        sut.dataAccessHelper = env.databaseQueue;
        accNumber = @"thanhld";
    });
    
    afterEach(^{
        env = nil;
        sut = nil;
        accNumber = nil;
    });
    
    context(@"insert new trans", ^{
        it(@"insert into empty database should success", ^{
            AccountLog *logWillInsert = [[AccountLog alloc] init];
            logWillInsert.accountNumber = accNumber;
            logWillInsert.amount = @100;
            logWillInsert.timestamp = [NSDate date];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            BOOL val = [sut insertAccountLogForTransaction:logWillInsert];
            [[theValue(val) should] equal:theValue(YES)];
        });
    });
    
    context(@"Get all transaction log with given account number", ^{
        it(@"There's no transaction log with given account number", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut getTransactionsOccurredWithAccountNumber:accNumber];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(0)];
        });
        
        it(@"There're some transactions with given account number, total should equal 5", ^{
            accNumber = @"thanhld";
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut getTransactionsOccurredWithAccountNumber:accNumber];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(5)];
        });
        
        it(@"There're some transactions but there's no transaction with given account number, total should equal 0", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut getTransactionsOccurredWithAccountNumber:@"012345"];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(0)];
        });
    });
    
    context(@"Get all transaction with given account number, start time, end time", ^{
        it(@"There're some transactions with given account number but timeOpened is not into between start time and end time", ^{
            accNumber = @"012345";
            NSString *startTime = @"2012-01-01 12:12:13";
            NSString *endTime = @"2012-01-02 12:12:12";
            NSDateFormatter *datefomater = [[NSDateFormatter alloc] init];
            [datefomater setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            NSDate *startDate = [datefomater dateFromString:startTime];
            NSDate *endDate = [datefomater dateFromString:endTime];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut getTransactionsOccurredWithAccountNumber:accNumber startTime:startDate andStopTime:endDate];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(0)];
        });
        
        it(@"There're some transactions with given account number but timeOpened is into between start time and end time.", ^{
            accNumber = @"thanhld";
            NSString *startTime = @"2012-01-01 12:12:13";
            NSString *endTime = @"2012-01-02 12:12:12";
            NSDateFormatter *datefomater = [[NSDateFormatter alloc] init];
            [datefomater setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            NSDate *startDate = [datefomater dateFromString:startTime];
            NSDate *endDate = [datefomater dateFromString:endTime];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc3" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut getTransactionsOccurredWithAccountNumber:accNumber startTime:startDate andStopTime:endDate];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(3)];
        });
    });
    
    context(@"Get n newest transaction with given account number", ^{
        it(@"Total transactions with given number is less than n. There're 5 trans in db, allTrans.count should return 5", ^{
            accNumber = @"thanhld";
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc4" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut getTransactionsOccurredWithAccountNumber:accNumber andNumberTransaction:20];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(5)];
        });
        
        it(@"Total transactions with given number is more than  or equal n. allTrans[0] should have timeOpened is 2012-01-01 23:12:16", ^{
            accNumber = @"thanhld";
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc5" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut getTransactionsOccurredWithAccountNumber:accNumber andNumberTransaction:10];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(10)];
            
            AccountLog *firstObject = [allTrans objectAtIndex:0];
            NSDateFormatter *dateFomater = [[NSDateFormatter alloc] init];
            [dateFomater setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            NSString *timeLast = [dateFomater stringFromDate:firstObject.timestamp];
            [[timeLast should] equal:@"2012-01-01 23:12:16"];
        });
        
    });
});

SPEC_END