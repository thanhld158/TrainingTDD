//
//  StringCalculatorDay9Tests.m
//  StringCalculatorDay9Tests
//
//  Created by Le Duy Thanh on 06/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculator.h"
#import "Kiwi.h"

SPEC_BEGIN(TestStringCalculator)

    describe(@"Test Add Function", ^{
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
            [[theValue([StringCalculator add:@"1,2\n3"]) should] equal:theValue(6)];
        });
        
        it(@"case 5", ^{
            [[theValue([StringCalculator add:@"//;\n1;2"]) should] equal:theValue(3)];
        });
        
        it(@"case 6", ^{
            [[theValue([StringCalculator add:@"//;\n1;2;-5;3;-4;6,8"]) should] equal:theValue(12)];
        });
        
        it(@"case 7", ^{
            [[theValue([StringCalculator add:@"//;\n1;2;-5;3;-4;6;1002;8"]) should] equal:theValue(20)];
        });
        
        it(@"case 8", ^{
            [[theValue([StringCalculator add:@"//***\n1***2***3"]) should] equal:theValue(6)];
        });
        
        it(@"case 9", ^{
            [[theValue([StringCalculator add:@"//[*][%]\n1*2%3"]) should] equal:theValue(6)];
        });
        
        it(@"case 10", ^{
            [[theValue([StringCalculator add:@"//[**][%]\n1**2%3"]) should] equal:theValue(6)];
        });
        
        it(@"case 11", ^{
            [[theValue([StringCalculator add:@"//[**][%!@]\n1**2%!@3%!@4"]) should] equal:theValue(10)];
            [[theValue([StringCalculator add:@"//[**][%!@]\n1**2%!@3%!@4,5"]) should] equal:theValue(15)];
        });
    });

SPEC_END
