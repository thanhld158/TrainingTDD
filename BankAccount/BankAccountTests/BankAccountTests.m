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
    
    beforeEach(^{
        mockDao = [BankAccountDAO nullMock];
        sut = [[BankAccount alloc] initWithDAO:mockDao andLogDAO:mockLogDao];
    });
    
    afterEach(^{
        mockDao = nil;
        sut = nil;
    });
    
    context(@"set up BankAccount", ^{
        it(@"bankAccountDAO shoud be exists", ^{
            [[sut.bankAccountDAO should] equal:mockDao];
        });
        
        it(@"open new account with account number", ^{
            NSString *mockAccountNumber = [NSString nullMock];
            
            Account *mockAccount = [Account nullMock];
            Account *accountExpect;
            
            [[sut should] receive:@selector(createNewAccoutWithAccountNumber:) andReturn:mockAccount withArguments:mockAccountNumber];
            [mockDao stub:@selector(insertToDBWithAccount:) andReturn:mockAccount withArguments:mockAccount];
            
            accountExpect = [sut openAccount:mockAccountNumber];
            [[accountExpect should] equal:mockAccount];
        });
        
        it(@"open new account with failure", ^{
            NSString *mockAccountNumber = [NSString nullMock];
            
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
            NSString *mockAccoutNumber = [NSString nullMock];
            Account *mockAccount = [Account nullMock];
            Account *accountResult;
            
            [mockAccount stub:@selector(accountNumber) andReturn:mockAccoutNumber];
            [mockDao stub:@selector(getAccount:) andReturn:mockAccount withArguments:mockAccoutNumber];
            
            accountResult = [sut getAccount:mockAccoutNumber];
            [[accountResult.accountNumber should] equal:mockAccoutNumber];
        });
        
        it(@"Deposit money to account", ^{
            NSString *mockAccountNumber = [NSString nullMock];
            NSNumber *mockAmount = [NSNumber nullMock];
            [mockAmount stub:@selector(integerValue) andReturn:theValue(10)];
            
            NSString *mockDescription = [NSString nullMock];
            Account *accountBefore = [Account nullMock];
            Account *accountReturn;
            Account *accountShouldBeReturned = [Account nullMock];
            
            [accountShouldBeReturned stub:@selector(balance) andReturn:[NSNumber numberWithInteger:(accountBefore.balance.integerValue + mockAmount.integerValue)]];
            
            [mockDao stub:@selector(deposit:moneyAmount:andDes:) andReturn:@{@"accountBefore":accountBefore, @"accountAfter":accountShouldBeReturned} withArguments:mockAccountNumber, mockAmount, mockDescription];
            
            accountReturn = [sut deposit:mockAccountNumber moneyAmount:mockAmount andDes:mockDescription];
            [[theValue(accountReturn.balance.integerValue) should] equal:theValue(accountBefore.balance.integerValue + mockAmount.integerValue)];
        });
        
        it(@"Save infomation into db when deposit", ^{
            Account *accountAfter;
            NSString *mockAccountNumber = [NSString nullMock];
            NSNumber *mockAmount = [NSNumber nullMock];
            NSString *mockDescription = [NSString nullMock];
            NSDate *mockDate = [NSDate nullMock];
            Account *accountShouldBeReturned = [Account nullMock];
            
            [accountShouldBeReturned stub:@selector(timestamp) andReturn:mockDate];
            [[mockDao should] receive:@selector(deposit:moneyAmount:andDes:) andReturn:mockDate withArguments:mockAccountNumber, mockAmount, mockDescription];
            [mockDao stub:@selector(deposit:moneyAmount:andDes:) andReturn:accountShouldBeReturned withArguments:mockAccountNumber, mockAmount, mockDescription];
            
            accountAfter = [sut deposit:mockAccountNumber moneyAmount:mockAmount andDes:mockDescription];
            [[accountAfter.timestamp should] equal:accountShouldBeReturned.timestamp];
        });
        
    });
    
});

SPEC_END
