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
        
        it(@"case 2", ^{
            [[theValue([StringCalculatorDay10 add:@"1"]) should] equal:theValue(1)];
        });
        
        it(@"case 3", ^{
            [[theValue([StringCalculatorDay10 add:@"1,2"]) should] equal:theValue(3)];
        });
        
        it(@"case 4", ^{
            [[theValue([StringCalculatorDay10 add:@"1,2\n3"]) should] equal:theValue(6)];
        });
        
        it(@"case 5", ^{
            [[theValue([StringCalculatorDay10 add:@"//;\n1;2"]) should] equal:theValue(3)];
        });
        
        it(@"case 6", ^{
            [[theValue([StringCalculatorDay10 add:@"//;\n1;2;-5;3;-4;6"]) should] equal:theValue(12)];
        });
        
        it(@"case 7", ^{
            [[theValue([StringCalculatorDay10 add:@"//;\n1;2;-5;3;-4;6;1002;8"]) should] equal:theValue(20)];
        });
        
        it(@"case 8", ^{
            [[theValue([StringCalculatorDay10 add:@"//***\n1***2***3"]) should] equal:theValue(6)];
        });
        
        it(@"case 9", ^{
            [[theValue([StringCalculatorDay10 add:@"//[*][%]\n1*2%3"]) should] equal:theValue(7)];
        });
        
    });

SPEC_END
