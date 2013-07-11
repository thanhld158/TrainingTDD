//
//  BankAccountTestThird.m
//  BankAccount
//
//  Created by Le Duy Thanh on 05/07/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "Kiwi.h"
#import "BankAccountDAO3.h"
#import "BankAccount3.h"
#import "BankAccountLogDAO3.h"

SPEC_BEGIN(BankAccountTestThird)

describe(@"Test bank account class", ^{
    __block BankAccount3 *sut;
    __block BankAccountDAO3 *bankAccountDAO;
    __block NSString *mockAccountNumber;
    __block BankAccountLogDAO3 *bankAccountLogDAO;
    
    beforeEach(^{
        sut = [[BankAccount3 alloc] init];
        bankAccountDAO = [BankAccountDAO3 nullMock];
        bankAccountLogDAO = [BankAccountLogDAO3 nullMock];
        mockAccountNumber = [NSString nullMock];
        sut.bankAccountDAO = bankAccountDAO;
        sut.bankAccountLogDAO = bankAccountLogDAO;
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
    
    context(@"Operation with bank account", ^{
        it(@"3. deposit into bank account, result: balance increase amount", ^{
            Account3 *accountAfterDeposit;
            NSNumber *amount = @(50);
            NSString *description = @"deposit";
            Account3 *accountBeforeDeposit = [Account3 nullMock];
            
            [accountBeforeDeposit stub:@selector(balance) andReturn:@(100)];
            [sut stub:@selector(getAccount:) andReturn:accountBeforeDeposit withArguments:mockAccountNumber];
            [bankAccountDAO stub:@selector(updateAccount:) andReturn:theValue(YES)];
            
            accountAfterDeposit = [sut deposit:mockAccountNumber amount:amount andDes:description];
            [[accountAfterDeposit.balance should] equal:@(accountBeforeDeposit.balance.doubleValue + amount.doubleValue)];
        });
        
        it(@"4. Information of transaction when depositing will be saved into db", ^{
            NSNumber *amount = @(50);
            NSString *description = @"deposit";
            NSDate *mockDate = [NSDate nullMock];
            AccountLog3 *mockAccLog = [AccountLog3 nullMock];
            
            [NSDate stub:@selector(date) andReturn:mockDate];
            [[sut should] receive:@selector(createAccLogWithAccountNumber:amount:andDes:)];
            [[bankAccountDAO should] receive:@selector(updateAccount:)];
            [bankAccountDAO stub:@selector(updateAccount:) andReturn:theValue(YES)];
            [sut stub:@selector(createAccLogWithAccountNumber:amount:andDes:) andReturn:mockAccLog];
            
            KWCaptureSpy *spy = [bankAccountLogDAO captureArgument:@selector(insertAccountLogForTransaction:) atIndex:0];
            [sut deposit:mockAccountNumber amount:amount andDes:description];
            
            AccountLog3 *accLogSaved = spy.argument;
            [[accLogSaved should] equal:mockAccLog];
        });
        
        it(@"5. withdraw from bank account, result: balance decrease amount", ^{
            NSNumber *amount = @(50);
            NSString *description = @"withdraw";
            Account3 *accountBefore = [Account3 nullMock];
            
            [bankAccountDAO stub:@selector(updateAccount:) andReturn:theValue(YES)];
            [accountBefore stub:@selector(balance) andReturn:@(100)];
            [sut stub:@selector(getAccount:) andReturn:accountBefore withArguments:mockAccountNumber];
            
            Account3 *accountAfterWithdraw = [sut withdraw:mockAccountNumber amount:amount andDes:description];
            [[accountAfterWithdraw.balance should] equal:@(accountBefore.balance.doubleValue - amount.doubleValue)];
        });
        
        it(@"6. Infomation of transaction when withdraw will be saved into db", ^{
            NSNumber *amount = @(50);
            NSString *description = @"withdraw";
            
            [bankAccountDAO stub:@selector(updateAccount:) andReturn:theValue(YES)];
            [[sut should] receive:@selector(createAccLogWithAccountNumber:amount:andDes:)];
            [[bankAccountLogDAO should] receive:@selector(insertAccountLogForTransaction:)];
            
            KWCaptureSpy *spy = [bankAccountLogDAO captureArgument:@selector(insertAccountLogForTransaction:) atIndex:0];
            
            [sut withdraw:mockAccountNumber amount:amount andDes:description];
            AccountLog3 *accLog = spy.argument;
            [[accLog.amount should] equal:@(-amount.doubleValue)];
        });
    });
    
    context(@"Operation with account log", ^{
        it(@"7. Get all transaction log of an account", ^{
            
        });
    });
});

SPEC_END
