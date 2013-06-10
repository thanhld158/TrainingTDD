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
        it(@"case 1: Test with emty string", ^{
            [[theValue([StringCalculatorDay10 add:@""]) should] equal:theValue(0)];
        });
        
        
        it(@"case 2: Test with string is a number", ^{
            [[theValue([StringCalculatorDay10 add:@"1"]) should] equal:theValue(1)];
        });
        
        
        it(@"case 3: Test with multi numbers in string", ^{
            [[theValue([StringCalculatorDay10 add:@"1,2"]) should] equal:theValue(3)];
        });
        
        
        it(@"case 4: Test with line break character", ^{
            [[theValue([StringCalculatorDay10 add:@"1,2\n3"]) should] equal:theValue(6)];
        });
        
        
        it(@"case 5: Test with new delimiter is defined by a character", ^{
            [[theValue([StringCalculatorDay10 add:@"//;\n1;2"]) should] equal:theValue(3)];
        });
        
        
        it(@"case 6: Test with negative number", ^{
            [[theBlock(^{
                [StringCalculatorDay10 add:@"1,2,-3,4,-5,-6"];
            }) should] raiseWithName:@"AddNegativeNumber" reason:@"negative numbers:-3,-5,-6"];
        });
        
        
        it(@"case 7: Test with number bigger than 1000 in string", ^{
            [[theValue([StringCalculatorDay10 add:@"//;\n1;2;3;6;1002;8"]) should] equal:theValue(20)];
        });
        
        
        it(@"case 8: Test with delimiter is a string", ^{
            [[theValue([StringCalculatorDay10 add:@"//***\n1***2***3"]) should] equal:theValue(6)];
        });
        
        
        it(@"case 9: Test with multiple delimiter", ^{
            [[theValue([StringCalculatorDay10 add:@"//[*][%]\n1*2%3"]) should] equal:theValue(6)];
        });
        
        
        it(@"case 10: Test with multiple delimiter", ^{
            [[theValue([StringCalculatorDay10 add:@"//[**][%]\n1**2%3"]) should] equal:theValue(6)];
        });
        
        
        it(@"case 11: Test with multiple delimiter", ^{
            [[theValue([StringCalculatorDay10 add:@"//[**][%!@]\n1**2%!@3%!@4"]) should] equal:theValue(10)];
        });
        
        
        it(@"case 12: Test with multiple delimiter", ^{
            [[theValue([StringCalculatorDay10 add:@"//[**][%!@]\n1**2%!@3%!@4,5"]) should] equal:theValue(15)];
        });
    });

SPEC_END
