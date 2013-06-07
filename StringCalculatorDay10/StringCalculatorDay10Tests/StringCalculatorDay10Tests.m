//
//  StringCalculatorDay10Tests.m
//  StringCalculatorDay10Tests
//
//  Created by Le Duy Thanh on 07/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculatorDay10.h"
#import "Kiwi.h"

SPEC_BEGIN(TestStringCalculatorDay10)

    describe(@"Test Add Function", ^{
        it(@"case 1", ^{
            [[theValue([StringCalculatorDay10 add:@""]) should] equal:theValue(0)];
        });
    });

SPEC_END
