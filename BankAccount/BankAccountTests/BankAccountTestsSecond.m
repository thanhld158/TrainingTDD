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
        
    });
});

SPEC_END