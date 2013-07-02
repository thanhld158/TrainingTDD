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

SPEC_BEGIN(BankAccountTestSecond)

describe(@"Bank Account Test Second", ^{
    
    __block NSString *mockAccountNumber;
    __block BankAccount2 *sut;
    __block BankAccountDAO2 *bankAccountDAO;
    
    beforeEach(^{
        mockAccountNumber = [NSString nullMock];
        sut = [[BankAccount2 alloc] init];
        bankAccountDAO = [BankAccountDAO2 nullMock];
        sut.bankAccountDAO = bankAccountDAO;
    });
    
    afterEach(^{
        mockAccountNumber = nil;
        sut = nil;
        bankAccountDAO = nil;
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
            
        });
    });
});

SPEC_END