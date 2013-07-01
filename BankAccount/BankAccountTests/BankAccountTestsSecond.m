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
});

SPEC_END