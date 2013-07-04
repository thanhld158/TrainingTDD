//
//  BankAccountTestsSecond.m
//  BankAccount
//
//  Created by Le Duy Thanh on 28/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "Kiwi.h"
#import "BankAccount2.h"
#import "BankAccountDAO2.h"
#import "BankAccountLogDAO2.h"

SPEC_BEGIN(BankAccountTestSecond)

describe(@"Bank Account Test Second", ^{
    
    __block NSString *mockAccountNumber;
    __block BankAccount2 *sut;
    __block BankAccountDAO2 *bankAccountDAO;
    __block BankAccountLogDAO2 *bankAccountLogDAO;
    
    beforeEach(^{
        mockAccountNumber = [NSString nullMock];
        sut = [[BankAccount2 alloc] init];
        bankAccountDAO = [BankAccountDAO2 nullMock];
        bankAccountLogDAO = [BankAccountLogDAO2 nullMock];
        sut.bankAccountDAO = bankAccountDAO;
        sut.bankAccountLogDAO = bankAccountLogDAO;
    });
    
    afterEach(^{
        mockAccountNumber = nil;
        sut = nil;
        bankAccountDAO = nil;
        bankAccountLogDAO = nil;
    });
    
    context(@"Setup bank account", ^{
        it(@"1. Open new account", ^{
            Account2 *accReturn;
            NSDate *openDate = [NSDate nullMock];
            
            [NSDate stub:@selector(date) andReturn:openDate];
            [[bankAccountDAO should] receive:@selector(insertNewAccount:) andReturn:any()];
            [bankAccountDAO stub:@selector(insertNewAccount:) andReturn:theValue(YES)];
            
            accReturn = [sut open:mockAccountNumber];
            [[accReturn.accountNumber should] equal:mockAccountNumber];
            [[accReturn.balance should] equal:@(0)];
            [[accReturn.openTimestamp should] equal:openDate];
        });
        
        it(@"2. Get infomation of an account with accountNumber argument", ^{
            Account2 *accReturn;
            Account2 *accShouldReturn = [Account2 nullMock];
            [accShouldReturn stub:@selector(accountNumber) andReturn:mockAccountNumber];
            [bankAccountDAO stub:@selector(getAccount:) andReturn:accShouldReturn withArguments:mockAccountNumber];
            
            accReturn = [sut getAccount:mockAccountNumber];
            [[accReturn.accountNumber should] equal:mockAccountNumber];
        });
    });
    
    context(@"Operation with a bank account", ^{
        it(@"3. deposit money into account, result: balance increase amount", ^{
            Account2 *accBefore = [Account2 nullMock];
            Account2 *accReturn;
            NSNumber *amount = @(100);
            NSString *des = @"deposit";
            
            [accBefore stub:@selector(balance) andReturn:@(50)];
            [sut stub:@selector(getAccount:) andReturn:accBefore withArguments:mockAccountNumber];
            [bankAccountDAO stub:@selector(updateBankAccount:) andReturn:theValue(YES)];
            
            accReturn = [sut deposit:mockAccountNumber amount:amount andDescription:des];
            [[accReturn.balance should] equal:@(accBefore.balance.doubleValue + amount.doubleValue)];
        });
        
        it(@"4. deposit infomation will be saved into db", ^{
            Account2 *accReturn;
            NSNumber *amount = @(100);
            NSString *des = @"deposit";
            
            // Check functions was call or not
            [[bankAccountDAO should] receive:@selector(updateBankAccount:) andReturn:theValue(YES)];
            [bankAccountDAO stub:@selector(updateBankAccount:) andReturn:theValue(YES)];
            
            [[sut should] receive:@selector(createAccountLogWithAccountNumber:amount:andDes:) withArguments:mockAccountNumber, amount, des];
            [[bankAccountLogDAO should] receive:@selector(insertAccountLog:) andReturn:theValue(YES)];
            
            accReturn = [sut deposit:mockAccountNumber amount:amount andDescription:des];
        });
        
        it(@"5. withdraw money from account, result: balance decrease amount", ^{
            Account2 *accBefore = [Account2 nullMock];
            Account2 *accReturn;
            NSNumber *amount = @(50);
            NSString *des = @"withdraw";
            
            [accBefore stub:@selector(balance) andReturn:@(100)];
            [sut stub:@selector(getAccount:) andReturn:accBefore withArguments:mockAccountNumber];
            [[sut should] receive:@selector(createAccountLogWithAccountNumber:amount:andDes:) withArguments:mockAccountNumber, amount, des];
            [bankAccountDAO stub:@selector(updateBankAccount:) andReturn:theValue(YES)];
            
            accReturn = [sut withdraw:mockAccountNumber amount:amount andDescription:des];
            [[accReturn.balance should] equal:@(accBefore.balance.doubleValue - amount.doubleValue)];
        });
        
        it(@"6. when after withdraw, infomation will be saved into db", ^{
            Account2 *accReturn;
            NSNumber *amount = @(100);
            NSString *des = @"withdraw";
            
            // Check functions was call or not
            [[bankAccountDAO should] receive:@selector(updateBankAccount:) andReturn:theValue(YES)];
            [bankAccountDAO stub:@selector(updateBankAccount:) andReturn:theValue(YES)];
            
            [[sut should] receive:@selector(createAccountLogWithAccountNumber:amount:andDes:) withArguments:mockAccountNumber, amount, des];
            [[bankAccountLogDAO should] receive:@selector(insertAccountLog:) andReturn:theValue(YES)];
            
            accReturn = [sut withdraw:mockAccountNumber amount:amount andDescription:des];
        });
    });
    
    context(@"Operation with transaction", ^{
        it(@"7. Get transaction list with an account", ^{
            NSArray *transactionList;
            
            // Check DAO
            [[bankAccountLogDAO should] receive:@selector(getTransactionsOccurredWithAccountNumber:) withArguments:mockAccountNumber];
            
            transactionList = [sut getTransactionsOccurred:mockAccountNumber];
        });
        
        it(@"8. Get transaction list between startTime and stopTime", ^{
            NSArray *transactionList;
            NSDate *startTime = [NSDate nullMock];
            NSDate *stopTime = [NSDate nullMock];
            
            // Check DAO
            [[bankAccountLogDAO should] receive:@selector(getTransactionsOccurredWithAccountNumber:startTime:stopTime:) withArguments:mockAccountNumber, startTime, stopTime];
            
            transactionList = [sut getTransactionsOccurred:mockAccountNumber startTime:startTime stopTime:stopTime];
        });
    });
});

SPEC_END