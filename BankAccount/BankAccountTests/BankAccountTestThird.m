//
//  BankAccountTestThird.m
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "Kiwi.h"
#import "Account3.h"
#import "BankAccountDAO3.h"
#import "BankAccount3.h"

SPEC_BEGIN(BankAccountTestThird)

describe(@"Test bank account class", ^{
    __block BankAccount3 *sut;
    __block BankAccountDAO3 *bankAccountDAO;
    __block NSString *mockAccountNumber;
    
    beforeEach(^{
        sut = [[BankAccount3 alloc] init];
        bankAccountDAO = [BankAccountDAO3 nullMock];
        mockAccountNumber = [NSString nullMock];
        sut.bankAccountDAO = bankAccountDAO;
    });
    
    afterEach(^{
        sut = nil;
        bankAccountDAO = nil;
        mockAccountNumber = nil;
    });
    
    context(@"Setup bank account", ^{
        it(@"1. Open new account with an accountNumber", ^{
            Account3 *accountOpened;
            NSDate *openDate = [NSDate nullMock];
            
            [NSDate stub:@selector(date) andReturn:openDate];
            [bankAccountDAO stub:@selector(insertNewAccount:) andReturn:theValue(YES)];
            
            //Check
            [[bankAccountDAO should] receive:@selector(insertNewAccount:) andReturn:any()];
            
            accountOpened = [sut open:mockAccountNumber];
            [[accountOpened.accountNumber should] equal:mockAccountNumber];
            [[accountOpened.balance should] equal:@(0)];
            [[accountOpened.openTimeStamp should] equal:openDate];
        });
        
        it(@"2. Get account infomation", ^{
            Account3 *accountReturn;
            
            //Check
            [[bankAccountDAO should] receive:@selector(getAccountWithAccountNumber:) andReturn:any()];
            
            KWCaptureSpy *spy = [bankAccountDAO captureArgument:@selector(getAccountWithAccountNumber:) atIndex:0];
            
            accountReturn = [sut getAccount:mockAccountNumber];
            NSString *accountNumberArg = spy.argument;
            [[mockAccountNumber should] equal:accountNumberArg];
        });
    });
});

SPEC_END
