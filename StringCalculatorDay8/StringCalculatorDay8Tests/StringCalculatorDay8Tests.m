//
//  StringCalculatorDay8Tests.m
//  StringCalculatorDay8Tests
//
//  Created by Le Duy Thanh on 05/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "Kiwi.h"
#import "StringCalculator.h"

SPEC_BEGIN(TestStringCalculator)

describe(@"Test Add function", ^{
    it(@"case 1", ^{
        [[theValue([StringCalculator add:@""]) should] equal:theValue(0)];
    });
    
    it(@"case 2", ^{
        [[theValue([StringCalculator add:@"1"]) should] equal:theValue(1)];
    });
    
    it(@"case 3", ^{
        [[theValue([StringCalculator add:@"1,2"]) should] equal:theValue(3)];
    });
    
    it(@"case 4", ^{
        [[theValue([StringCalculator add:@"1\n2,3"]) should] equal:theValue(6)];
    });
    
    it(@"case 5", ^{
        [[theValue([StringCalculator add:@"//;\n1;2"]) should] equal:theValue(3)];
    });
    
    it(@"case 6", ^{
        [[theValue([StringCalculator add:@"// \n1 2 3"]) should] equal:theValue(6)];
    });
});

SPEC_END

