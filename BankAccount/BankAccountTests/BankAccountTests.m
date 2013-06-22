//
//  BankAccountTests.m
//  BankAccountTests
//
//  Created by Le Duy Thanh on 11/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "Kiwi.h"
#import "BankAccount.h"
#import "BankAccountDAO.h"
#import "Account.h"
#import "AccountLog.h"
#import "AccountLogDAO.h"

SPEC_BEGIN(BankAccountServiceTest)
describe(@"BankAccount Test", ^{
    
    __block BankAccountDAO *mockDao;
    __block AccountLogDAO *mockLogDao;
    __block BankAccount *sut;
    __block NSString *mockAccountNumber;
    
    beforeEach(^{
        mockDao = [BankAccountDAO nullMock];
        mockLogDao = [AccountLogDAO nullMock];
        mockAccountNumber = [NSString nullMock];
        sut = [[BankAccount alloc] initWithDAO:mockDao andLogDAO:mockLogDao];
    });
    
    afterEach(^{
        mockDao = nil;
        sut = nil;
        mockLogDao = nil;
        mockAccountNumber = nil;
    });
    
    context(@"set up BankAccount", ^{
        it(@"bankAccountDAO shoud be exists", ^{
            [[sut.bankAccountDAO should] equal:mockDao];
            [[sut.accountLogDAO should] equal:mockLogDao];
        });
        
        it(@"open new account with account number", ^{
            Account *mockAccount = [Account nullMock];
            Account *accountExpect;
            
            [[sut should] receive:@selector(createNewAccoutWithAccountNumber:) andReturn:mockAccount withArguments:mockAccountNumber];
            [mockDao stub:@selector(insertToDBWithAccount:) andReturn:mockAccount withArguments:mockAccount];
            
            accountExpect = [sut openAccount:mockAccountNumber];
            [[accountExpect should] equal:mockAccount];
        });
        
        it(@"open new account with failure", ^{
            Account *mockAccount = [Account nullMock];
            Account *accountExpect;
            
            [[sut should] receive:@selector(createNewAccoutWithAccountNumber:) andReturn:mockAccount withArguments:mockAccountNumber];
            [mockDao stub:@selector(insertToDBWithAccount:) andReturn:nil withArguments:mockAccount];
            
            accountExpect = [sut openAccount:mockAccountNumber];
            [accountExpect shouldBeNil];
        });
        
        it(@"Test create Accont", ^{
            NSString *mockString = [NSString nullMock];
            Account *account = [sut createNewAccoutWithAccountNumber:mockString];
            [[account.accountNumber should] equal:mockString];
            [[account.balance should] equal:@0];
        });
        
        it(@"Get account", ^{
            Account *mockAccount = [Account nullMock];
            Account *accountResult;
            
            [mockAccount stub:@selector(accountNumber) andReturn:mockAccountNumber];
            [mockDao stub:@selector(getAccount:) andReturn:mockAccount withArguments:mockAccountNumber];
            
            accountResult = [sut getAccount:mockAccountNumber];
            [[accountResult.accountNumber should] equal:mockAccountNumber];
        });
        
    });
    
    context(@"Deposit money into account", ^{
        it(@"Deposit money to account", ^{
            NSNumber *mockAmount = @(123.45);
            
            NSString *mockDescription = [NSString nullMock];
            Account *accountBefore = [Account nullMock];
            Account *accountReturn = nil;
            
            [accountBefore stub:@selector(balance) andReturn:@(3)];
            // Check getAccount: was call or not
            [[sut should] receive:@selector(getAccount:) andReturn:accountBefore withArguments:mockAccountNumber];
            [sut stub:@selector(getAccount:) andReturn:accountBefore withArguments:mockAccountNumber];
            
            [[mockDao should] receive:@selector(updateAcountWithAcount:) andReturn:theValue(YES) withArguments:any()];
            [mockDao stub:@selector(updateAcountWithAcount:) andReturn:theValue(YES) withArguments:accountReturn];
            
            accountReturn = [sut deposit:mockAccountNumber moneyAmount:mockAmount andDes:mockDescription];
            [[theValue(accountReturn.balance.doubleValue) should] equal:theValue(accountBefore.balance.doubleValue + mockAmount.doubleValue)];
        });
        
        it(@"Create a account log when deposit", ^{
            NSNumber *mockAmount = [NSNumber nullMock];
            NSString *mockDescription = [NSString nullMock];
            NSDate *mockDate = [NSDate nullMock];
            
            [NSDate stub:@selector(date) andReturn:mockDate];
            
            AccountLog *accLog = [sut createAccountLogWithAccNumber:mockAccountNumber moneyAmount:mockAmount andDes:mockDescription];
            
            [[accLog.accountNumber should]equal:mockAccountNumber];
            [[accLog.amount should] equal:mockAmount];
            [[accLog.description should] equal:mockDescription];
            [[accLog.timestamp should] equal:mockDate];
        });
        
        it(@"Save infomation (Account log)  into db when deposit", ^{
            Account *accountAfter;
            NSNumber *mockAmount = [NSNumber nullMock];
            NSString *mockDescription = [NSString nullMock];
            
            [[mockDao should] receive:@selector(updateAcountWithAcount:) andReturn:theValue(YES)];
            [[mockLogDao should] receive:@selector(insertToDBWithAccountLog:)];
            // Check createAccount was call or not
            [[sut should] receive:@selector(createAccountLogWithAccNumber:moneyAmount:andDes:)];
            
            accountAfter = [sut deposit:mockAccountNumber moneyAmount:mockAmount andDes:mockDescription];
        });
    });
    
    context(@"BankAccount with draw", ^{
        
    });
    
});

SPEC_END
